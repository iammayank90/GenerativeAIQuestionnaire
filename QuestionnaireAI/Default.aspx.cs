using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Profile;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuestionnaireAI
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public async static Task<string> SubmitResp(string prompt)
        {
            string Answer = string.Empty;
            string apiKey = "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";
            // Your OpenAI API key

            var apiUrl = "https://api.openai.com/v1/chat/completions";

            // HttpClient is intended to be instantiated once and re-used throughout the life of an application.
            using (var httpClient = new HttpClient())
            {
                // Setting the authorization header
                httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiKey}");

                // Data for the POST request
                var postData = new
                {
                    model = "gpt-3.5-turbo",
                    messages = new[]
                {
                    new { role = "system", content = "You are a helpful assistant." },
                    new { role = "user", content = prompt },
                    new { role = "user", content = "give 50 questions for due diligence" },
                    new { role = "user", content = "Set the response in number order" },
                    new { role = "user", content = "Make yes/no, dropdown and multichose questions as well" },
                    new { role = "user", content = "By all questions third party should be accecpted or rejected" }
                    },
                    temperature = 1,
                    max_tokens = 256,
                    top_p = 1,
                    frequency_penalty = 0,
                    presence_penalty = 0
                };

                var json = JsonConvert.SerializeObject(postData);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                try
                {
                    var response = await httpClient.PostAsync(apiUrl, content);
                    response.EnsureSuccessStatusCode();
                    var responseBody = await response.Content.ReadAsStringAsync();

                    // Assuming the response is JSON and you want to parse it
                    var result = JsonConvert.DeserializeObject<dynamic>(responseBody);
                    Answer = result.choices[0].message.content.ToString();
                }
                catch (HttpRequestException e)
                {
                    Console.WriteLine("\nException Caught!");
                    Console.WriteLine("Message :{0} ", e.Message);
                }
            }
            return Answer;
        }

        [WebMethod(EnableSession = false)]
        public static string YourMethod(string parameter)
        {
            // Your logic here
            return "Response from YourMethod";
        }
    }
}