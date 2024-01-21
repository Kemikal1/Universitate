using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Universitate.Pages
{
    public class GetByIdModel : PageModel
    {
        private readonly ILogger<GetByIdModel> _logger;
        private readonly IConfiguration _configuration;

        public GetByIdModel(ILogger<GetByIdModel> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public void OnGet()
        {
            // Your OnGet logic here
        }

       [HttpGet]
       public async Task<IActionResult> OnGetStudentById(int id)
        {
            var student = await GetStudentById(id);

            if (student == null)
            {
                return new JsonResult(new { Message = $"Student with ID {id} not found" }) { StatusCode = 404 };
            }

            var result = new
            {
                student.Id,
                student.Nume,
                student.Prenume,
                Subjects = GetStudentSubjects(id)
            };
            Console.WriteLine(result);
            return new JsonResult(result);
        }

        private async Task<Student> GetStudentById(int id)
        {
            using (SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                await connection.OpenAsync();

                string query = "SELECT * FROM Student WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            return new Student
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("Id")),
                                Nume = reader.GetString(reader.GetOrdinal("Nume")),
                                Prenume = reader.GetString(reader.GetOrdinal("Prenume"))
                            };
                        }
                    }
                }
            }

            return null;
        }

        private IEnumerable<object> GetStudentSubjects(int studentId)
        {
            List<object> subjects = new List<object>();

            using (SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();

                string query = "SELECT Materie.Nume, Note.Nota FROM Note " +
                                "INNER JOIN Materie ON Note.Materia = Materie.Id " +
                                "WHERE Note.Student = @StudentId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentId", studentId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            subjects.Add(new
                            {
                                Nume = reader.GetString(reader.GetOrdinal("Nume")),
                                Nota = reader.GetInt32(reader.GetOrdinal("Nota"))
                            });
                            Console.WriteLine(subjects[0]);
                        }
                    }
                }
            }

            return subjects;
        }

        [HttpGet]
        public JsonResult OnGetStudentsWithMoreThanThreeSubjects()
        {
            var students = GetStudentsWithMoreThanThreeSubjects();
            return new JsonResult(students);
        }

        private IEnumerable<object> GetStudentsWithMoreThanThreeSubjects()
        {
            List<object> students = new List<object>();

            using (SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();

                string query = "SELECT DISTINCT Student.Id, Student.Nume, Student.Prenume " +
                                "FROM Student " +
                                "INNER JOIN Note ON Student.Id = Note.Student " +
                                "GROUP BY Student.Id, Student.Nume, Student.Prenume " +
                                "HAVING COUNT(Note.Materia) > 3";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            students.Add(new
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("Id")),
                                Nume = reader.GetString(reader.GetOrdinal("Nume")),
                                Prenume = reader.GetString(reader.GetOrdinal("Prenume"))
                                
                            });
                            
                        }
                    }
                }
            }

            return students;
        }

        public class Student
        {
            public int Id { get; set; }
            public string Nume { get; set; }
            public string Prenume { get; set; }
        }
        public Student StudentInstance = new Student();
    }
}
