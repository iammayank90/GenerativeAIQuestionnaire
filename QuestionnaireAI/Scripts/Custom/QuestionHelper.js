(function () {
    localStorage.setItem('sessionData', '');
})();




function createquestions() {
    const apiKey = "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"; // Your OpenAI API key
    const apiUrl = "https://api.openai.com/v1/chat/completions";
    const input = document.getElementById('queryInput').value;

    // Data for the POST request
    const postData = {
        model: "gpt-3.5-turbo",
        messages: [
            { "role": "system", "content": "You are a helpful assistant." },
            { "role": "user", "content": "Create a questionnaire to third party companies for top executives of" },
            { "role": "user", "content": input },
            { "role": "user", "content": "give 50 questions for due diligence" },
            { "role": "user", "content": "Set the response in number order" },
            { "role": "user", "content": "Make yes/no, dropdown, multichose checkbox, radio button and text box questions as well" },
            { "role": "user", "content": "By all questions third party should be accepted or rejected" },
            { "role": "user", "content": "give appropriate answers and don't give half or empty text" },
            { "role": "user", "content": "include all type of questions" }
        ],
        temperature: 1,
        max_tokens: 256,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
    };

    // Make the POST request using fetch
    fetch(apiUrl, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${apiKey}`
        },
        body: JSON.stringify(postData)
    }).then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    }).then(data => {
        let msgresponse = data.choices[0].message.content;
        localStorage.setItem('sessionData', msgresponse);
        const questions = msgresponse.split("\n");

        const listElement = document.getElementById('queryList');

        questions.forEach(question => {
            const listItem = document.createElement('li');
            listItem.textContent = question;
            listElement.appendChild(listItem);
        });

        

        console.log(data); // Process the response data
    }).catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
    });

}


function exportquest() {

    // var settings = {
    // "url": "http://localhost:5215/WeatherForecast",
    // "method": "POST",
    // "timeout": 0,
    // "headers": {
    // "Content-Type": "application/json"
    // },
    // "data": JSON.stringify({"GptResponse": "jjk"}), 
    // };

    // $.ajax(settings).done(function (response) {
    // console.log(response);
    // });

    var sessionData = localStorage.getItem('sessionData');
    localStorage.setItem('sessionData', '');
    if (sessionData != '') {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        let lines = sessionData.split("\n");

        doc.text(sessionData.split("\n"), 20, 20);


        let y = 20; // Initial Y offset

        lines.forEach(line => {
            if (line.trim() !== '') {
                doc.text(line, 20, y);
                y += 10; // Increase Y offset for each line
            } else {
                y += 5; // Add a smaller space for empty lines (paragraph spacing)
            }

            // Check if we're near the bottom of the page
            if (y > 280) {
                doc.addPage();
                y = 20; // Reset Y offset
            }
        });


        doc.save("example.pdf");
    }
    else {
        alert('No data to export');
    }
}

function clearFields() {
    localStorage.setItem('sessionData', '');
    document.getElementById('queryInput').value = '';
    document.getElementById('queryList').innerHTML = '';
}