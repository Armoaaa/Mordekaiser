namespace Mordekaiser.AdoDapper.Test
{
    public abstract class TestBase
    {
        protected readonly IDbConnection Conexion;
        protected readonly IDao dao;

        public TestBase()
        {
        
            IConfiguration config = new ConfigurationBuilder()
                .AddJsonFile("appSettings.json", optional: true, reloadOnChange: true)
                .Build();


            string cadena = config.GetConnectionString("MySQL")!;
            Conexion = new MySqlConnection(cadena);
            dao = new DaoDapper(Conexion);
        }

    }
}
