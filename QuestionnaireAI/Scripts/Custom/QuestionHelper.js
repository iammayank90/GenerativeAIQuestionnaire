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
            { "role": "user", "content": "Make dropdown, multichose checkbox, radio button and text box questions as well" },
            { "role": "user", "content": "By all questions third party should be accepted or rejected" },
            { "role": "user", "content": "give appropriate answers only having number and don't give half or empty Answer" },
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

    var sessionData = localStorage.getItem('sessionData');
    localStorage.setItem('sessionData', '');
    if (sessionData != '') {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        let lines = sessionData.split("\n");

        
        const maxWidth = 180; // Adjust based on your document's margin

        // Use splitTextToSize to handle word wrap
        const splitText = doc.splitTextToSize(sessionData, maxWidth);

        // Initial Y offset
        let y = 20;

        // Loop through the lines returned by splitTextToSize
        splitText.forEach(line => {
            // Check if we're near the bottom of the page to add a new page
            if (y > 280) {
                doc.addPage();
                y = 20; // Reset Y position
            }

            doc.text(line, 20, y);
            y += 10; // Increment Y position for each line
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


document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('upload').addEventListener('change', function (e) {
        const file = e.target.files[0];
        const reader = new FileReader();
        reader.onload = function (e) {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, { type: 'array' });

            // Assuming you're working with the first sheet
            const sheetName = "QuestionnaireItem";
            const worksheet = workbook.Sheets[sheetName];

            // Add rows here. Example: add a row to the end of the sheet
            const ref = XLSX.utils.decode_range(worksheet['!ref']);
            const newRow = ref.e.r + 1; // Assuming there's at least one row

            // Example: Adding data in the first and second columns of the new row
            XLSX.utils.sheet_add_aoa(worksheet, [['QuestionnaireVersion', 1, 'genQuest112', 'hi mm', 'TextBox', 11, 'False', 'False', '', 'False', '', '', '', 'EN', 'genQuest112', 'genQuest117', 'True', 'CustomQuestionMapping', 0]], { origin: -1 });

            // Update workbook with the new sheet data
            workbook.Sheets[sheetName] = worksheet;

            // Store workbook globally for access in the download function
            window.modifiedWorkbook = workbook;
        };
        reader.readAsArrayBuffer(file);
    });
});

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('addRows').addEventListener('click', function () {
        if (!window.modifiedWorkbook) {
            alert('Please upload a file first.');
            return;
        }

        // Save the modified workbook
        XLSX.writeFile(window.modifiedWorkbook, 'ModifiedFile.xlsx');
    });
});
