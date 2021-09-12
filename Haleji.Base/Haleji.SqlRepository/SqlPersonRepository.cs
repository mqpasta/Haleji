using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Irada.Common.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Haleji.SqlRepository
{
    public class SqlPersonRepository : IPersonRepository
    {
        private string _constr = SQLHelper.ConnectionString;

        private static Person ExtractRow(DataRow r)
        {
            // nullabel fields
            var deptId = r["DepartmentId"];
            var ext = r["Ext"];
            var cont = r["Contact"];
            var deptname = r["DepartmentName"];

            return new Person()
            {
                PersonId = Convert.ToInt64(r["PersonId"]),
                Name = Convert.ToString(r["Name"]),
                IsActive = Convert.ToBoolean(r["IsActive"]),
                DepartmentId = DBNull.Value.Equals(deptId) ? null : Convert.ToInt64(deptId),
                Ext = DBNull.Value.Equals(ext) ? null : Convert.ToString(ext),
                Contact = DBNull.Value.Equals(cont) ? null : Convert.ToString(cont),
                DepartmentName = DBNull.Value.Equals(deptname) ? null : Convert.ToString(deptname)
            };

        }

        public void Add(Person entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Person.GetName(entity.Name));
            ps.Add(StoredProcedures.Person.GetDpartmentId(entity.DepartmentId));
            ps.Add(StoredProcedures.Person.GetExt(entity.Ext));
            ps.Add(StoredProcedures.Person.GetContact(entity.Contact));
            ps.Add(StoredProcedures.Person.GetIsActive(entity.IsActive));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                var r = SQLHelper.ExecuteScalar(con, StoredProcedures.Person.Insert, ps.ToArray());
                con.Close();

                entity.PersonId = Convert.ToInt64(r);
            }
        }

        public IEnumerable<Person> GetAll()
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            List<Person> persons = new List<Person>();

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Person.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        persons.Add(ExtractRow(r));
                }
            }

            return persons;
        }

        public Person GetById(long id)
        {
            Person p = new Person();
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Person.GetPersonId(id));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Person.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        p = ExtractRow(r);
                    }
                }

                return p;
            }
        }

        public void Remove(Person entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Person.GetPersonId(entity.PersonId));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Person.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(Person entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Person.GetPersonId(entity.PersonId));
            ps.Add(StoredProcedures.Person.GetName(entity.Name));
            ps.Add(StoredProcedures.Person.GetDpartmentId(entity.DepartmentId));
            ps.Add(StoredProcedures.Person.GetExt(entity.Ext));
            ps.Add(StoredProcedures.Person.GetContact(entity.Contact));
            ps.Add(StoredProcedures.Person.GetIsActive(entity.IsActive));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Person.Update, ps.ToArray());
                con.Close();
            }
        }
    }
}
