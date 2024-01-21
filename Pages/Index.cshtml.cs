using System.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.IO;
namespace Universitate.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;

    public IndexModel(ILogger<IndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        IConfiguration configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .Build();
        
        string connectionString = configuration.GetConnectionString("DefaultConnection");
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();
            Console.WriteLine(con.Database);
            using (SqlCommand command = new SqlCommand("SELECT * FROM Grupa", con))
            {
               
                
                 
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    
                    
                    while (reader.Read())
                    {
                         
                        var columnValue = reader[1];
                        
                        Console.WriteLine(columnValue);
                    }
                }
            }
        }
    }
}
