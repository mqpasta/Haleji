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
    public class SqlVendorRepository : IVendorRepository
    {
        private readonly string _constr = SQLHelper.ConnectionString;

        public void Add(Vendor entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>
            {
                StoredProcedures.Vendor.GetVendorName(entity.VendorName),
                StoredProcedures.Vendor.GetAddress(entity.Address),
                StoredProcedures.Vendor.GetContactPerson(entity.ContactPerson),
                StoredProcedures.Vendor.GetContact(entity.Contact),
                StoredProcedures.Vendor.GetNote(entity.Note)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                var r = SQLHelper.ExecuteScalar(con, StoredProcedures.Vendor.Insert, ps.ToArray());
                con.Close();

                entity.VendorId = Convert.ToInt64(r);
            }
        }

        public IEnumerable<Vendor> GetAll()
        {
            List<Vendor> vendors = new();
            List<SqlParameter> ps = new();

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Vendor.GetAll, ps.ToArray());
                con.Close();

                if(ds.Tables.Count>0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        vendors.Add(ExtractRow(r));
                }
            }

            return vendors;
        }

        private static Vendor ExtractRow(DataRow r)
        {
            var vid = r["VendorId"];
            var vname = r["VendorName"];
            var add = r["Address"];
            var cp = r["ContactPerson"];
            var c = r["Contact"];
            var n = r["Note"];

            return new Vendor()
            {
                VendorId = Convert.ToInt64(vid),
                VendorName = Convert.ToString(vname),
                Address = (DBNull.Value.Equals(add)) ? null : Convert.ToString(add),
                ContactPerson = DBNull.Value.Equals(cp) ? null : Convert.ToString(cp),
                Contact = DBNull.Value.Equals(c) ? null : Convert.ToString(c),
                Note = DBNull.Value.Equals(n) ? null : Convert.ToString(n)
            };
        }

        public Vendor GetById(long id)
        {
            Vendor v = new Vendor();
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Vendor.GetVendorId(id));

            using(SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Vendor.Search, ps.ToArray());
                con.Close();

                if(ds.Tables.Count>0)
                {
                    foreach(DataRow r in ds.Tables[0].Rows)
                    {
                        v = ExtractRow(r);
                    }
                }
            }

            return v;
        }

        public void Remove(Vendor entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Vendor.GetVendorId(entity.VendorId));

            using(SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Vendor.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(Vendor entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Vendor.GetVendorId(entity.VendorId));
            ps.Add(StoredProcedures.Vendor.GetVendorName(entity.VendorName));
            ps.Add(StoredProcedures.Vendor.GetAddress(entity.Address));
            ps.Add(StoredProcedures.Vendor.GetContactPerson(entity.ContactPerson));
            ps.Add(StoredProcedures.Vendor.GetContact(entity.Contact));
            ps.Add(StoredProcedures.Vendor.GetNote(entity.Note));

            using(SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Vendor.Update, ps.ToArray());
                con.Close();
            }

        }
    }
}
