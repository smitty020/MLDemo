using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Web.Services;


namespace MLDemo
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //  InvokeRequestResponseService();

        }

        public class ScoreData
        {
            public Dictionary<string, string> FeatureVector { get; set; }
            public Dictionary<string, string> GlobalParameters { get; set; }
        }


        public class ScoreRequest
        {
            public string Id { get; set; }
            public ScoreData Instance { get; set; }
        }

        [WebMethod]
        public static string InvokeCall(List<string> paramList)
        {
            return InvokeRequestResponseService(paramList);
        }

        public static string InvokeRequestResponseService(List<string> paramList)
        {
            using (var client = new HttpClient())
            {
                ScoreData scoreData = new ScoreData()
                {
                    FeatureVector = new Dictionary<string, string>() 
                    {
                        //{ "Status of checking account", "A12" },
                        //{ "Duration in months", "48" },
                        //{ "Credit history", "A32" },
                        //{ "Purpose", "A43" },
                        //{ "Credit amount", "5951" },
                        //{ "Savings account/bond", "A61" },
                        //{ "Present employment since", "A73" },
                        //{ "Installment rate in percentage of disposable income", "2" },
                        //{ "Personal status and sex", "A92" },
                        //{ "Other debtors", "A101" },
                        //{ "Present residence since", "2" },
                        //{ "Property", "A121" },
                        //{ "Age in years", "22" },
                        //{ "Other installment plans", "A143" },
                        //{ "Housing", "A152" },
                        //{ "Number of existing credits", "1" },
                        //{ "Job", "A173" },
                        //{ "Number of people providing maintenance for", "1" },
                        //{ "Telephone", "A191" },
                        //{ "Foreign worker", "A201" },
                        { "Status of checking account", paramList[0] },
                        { "Duration in months", paramList[1] },
                        { "Credit history", paramList[2] },
                        { "Purpose", paramList[3] },
                        { "Credit amount", paramList[4] },
                        { "Savings account/bond", paramList[5] },
                        { "Present employment since", paramList[6] },
                        { "Installment rate in percentage of disposable income", paramList[7] },
                        { "Personal status and sex", paramList[8] },
                        { "Other debtors", paramList[9] },
                        { "Present residence since", paramList[10] },
                        { "Property", paramList[11] },
                        { "Age in years", paramList[12] },
                        { "Other installment plans", paramList[13] },
                        { "Housing", paramList[14] },
                        { "Number of existing credits", paramList[15] },
                        { "Job", paramList[16] },
                        { "Number of people providing maintenance for", paramList[17] },
                        { "Telephone", paramList[18] },
                        { "Foreign worker", paramList[19] },

                    },
                    GlobalParameters = new Dictionary<string, string>()
                    {

                    }
                };

                ScoreRequest scoreRequest = new ScoreRequest()
                {
                    Id = "score00001",
                    Instance = scoreData
                };

                const string apiKey = "aQa2b2TjArfqxT5ZJVnqUWfexKANfiSK5NDxPNCXdO2qJP42onFAby6wtPPCBU/omXDHyD9IGtC0kcQar9B5oQ=="; // Replace this with the API key for the web service
                                      
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);

                client.BaseAddress = new Uri("https://ussouthcentral.services.azureml.net/workspaces/5d995719779044fe852e72abc931b5f4/services/a91ba0919cb14dec9c65d53a6d39d083/score");

                HttpResponseMessage response = client.PostAsJsonAsync("", scoreRequest).Result;
               
                
                if (response.IsSuccessStatusCode)
                {
                    string result = response.Content.ReadAsStringAsync().Result;
                    return result;
                    
                    //List<string> list = new JavaScriptSerializer().Deserialize<List<string>>(result);
                   // string x = "";
                    //return x;
                    
                }
                else
                {
                    return String.Format(@"Failed with status code: {0}" , response.StatusCode);
                }
            }
        }

    }
}