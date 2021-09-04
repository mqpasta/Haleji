using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Irada.Common.DAL;

namespace Haleji.SqlRepository
{
    public class SqlDepartmentRepository : IDepartmentRepository
    {
        private const string DepartmentId = "DepartmentId";
        private const string DepartmentName = "DepartmentName";
        private static string _constr = SQLHelper.ConnectionString;
        public void Add(Department entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Department.GetDeptName(entity.DepartmentName));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                var r = SQLHelper.ExecuteScalar(con, StoredProcedures.Department.Insert, ps.ToArray());
                con.Close();

                entity.DepartmentId = Convert.ToInt64(r);
            }
        }

        public IEnumerable<Department> GetAll()
        {
            List<Department> departments = new List<Department>();
            List<SqlParameter> ps = new List<SqlParameter>();
            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Department.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        departments.Add(ExtractRow(r));
                    }
                }
            }

            return departments;
        }

        private static Department ExtractRow(DataRow r)
        {
            return new Department()
            {
                DepartmentId = Convert.ToInt64(r[DepartmentId]),
                DepartmentName = Convert.ToString(r[DepartmentName])
            };
        }

        public Department GetById(long id)
        {
            Department d = new Department();
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Department.GetDeptId(id));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Department.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        d = ExtractRow(r);
                    }
                }
            }

            return d;
        }

        public void Remove(Department entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Department.GetDeptId(entity.DepartmentId));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Department.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(Department entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Department.GetDeptId(entity.DepartmentId));
            ps.Add(StoredProcedures.Department.GetDeptName(entity.DepartmentName));

            using (SqlConnection con = new SqlConnection(SQLHelper.ConnectionString))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Department.Update, ps.ToArray());
                con.Close();
            }
                
        }
    }
}
