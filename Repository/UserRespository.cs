using System;
using Microsoft.AspNetCore.Mvc;
using Npgsql;

namespace net_core_project.Repository
{
    public class UserRepository
    {
        public UserRepository(){}
        public void CreateConnection(){
            var connectionString = "Server=localhost;Port=5432;Database=TestDataBase;User Id=postgres;Password=forrito666;";
           
        }
    }
}
