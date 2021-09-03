using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Irada.Common.DAL
{
    public class SQLHelper
    {
        private static SqlConnection _connection;
        private static string _connectionString = @"Data Source={0};Initial Catalog={1};User ID={2};Password={3};{4}";

        public static void SetConnectionString(string dbServer, string dbName,
                                                string userId, string password,
                                                bool trustedConnection)
        {
            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
            builder.DataSource = dbServer;
            builder.InitialCatalog = dbName;
            if (trustedConnection)
                builder.IntegratedSecurity = true;
            else
            {
                builder.IntegratedSecurity = false;
                builder.UserID = userId;
                builder.Password = password;
            }
            _connectionString = builder.ConnectionString;
        }

        public static string ConnectionString
        {
            get { return _connectionString; }
        }

        private SQLHelper()
        {

        }

        public static SqlConnection Instance
        {
            get
            {
                if (_connection == null)
                {
                    _connection = new SqlConnection(_connectionString);
                }
                return _connection;
            }
        }

        public static object ExecuteScalar(SqlConnection con, string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            return cmd.ExecuteScalar();
        }

        public static object ExecuteScalar(SqlConnection con, string query, SqlTransaction trans)
        {
            SqlCommand cmd = new SqlCommand(query, con, trans);
            return cmd.ExecuteScalar();
        }

        public static object ExecuteScalar(SqlConnection con, string name, params SqlParameter[] parameters)
        {
            return ExecuteScalar(con, name, null, parameters);
        }

        public static object ExecuteScalar(SqlConnection con, string name, SqlTransaction trans, params SqlParameter[] parameters)
        {
            string spName = name;
            SqlCommand cmd;
            if (trans != null)
                cmd = new SqlCommand(spName, con);
            else
                cmd = new SqlCommand(spName, con, trans);

            cmd.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter p in parameters)
                cmd.Parameters.Add(p);

            return cmd.ExecuteScalar();
        }

        public static void Execute(SqlConnection con, string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
        }

        public static void Execute(SqlConnection con, string query, SqlTransaction trans)
        {
            SqlCommand cmd = new SqlCommand(query, con, trans);
            cmd.ExecuteNonQuery();
        }

        public static void Execute(SqlConnection con, string name, SqlTransaction trans, params SqlParameter[] parameters)
        {
            SqlCommand cmd;
            if (trans != null)
                cmd = new SqlCommand(name, con, trans);
            else
                cmd = new SqlCommand(name, con);
            cmd.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter p in parameters)
                cmd.Parameters.Add(p);

            cmd.ExecuteNonQuery();
        }

        public static void Execute(SqlConnection con, string name, params SqlParameter[] parameters)
        {
            Execute(con, name, null, parameters);
        }

        public static DataSet LoadData(SqlConnection con, string query)
        {
            DataSet ds = new DataSet();// to store reuslt
            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(ds);

            return ds;
        }

        public static DataSet LoadData(SqlConnection con, string query, SqlTransaction trans)
        {
            DataSet ds = new DataSet();// to store reuslt
            SqlCommand cmd = new SqlCommand(query, con, trans);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(ds);

            return ds;
        }

        public static DataSet LoadData(SqlConnection con, string name, params SqlParameter[] parameters)
        {
            return LoadData(con, name, null, parameters);
        }

        public static DataSet LoadData(SqlConnection con, string name, SqlTransaction trans, params SqlParameter[] parameters)
        {
            DataSet ds = new DataSet();// to store reuslt
            string spName = name;

            SqlCommand cmd;
            if (trans == null)
                cmd = new SqlCommand(spName, con);
            else
                cmd = new SqlCommand(spName, con, trans);

            cmd.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter p in parameters)
                cmd.Parameters.Add(p);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(ds);

            return ds;
        }

        public static List<SqlParameter> GetEmptyParams()
        {
            return new List<SqlParameter>();
        }
    }
}
