using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Irada.Common.DAL;

namespace Haleji.SqlRepository
{
    public class SqlItemDetailsRepository : IItemDetailsRepository
    {
        private readonly string _constr = SQLHelper.ConnectionString;

        public void Add(ItemDetails entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.ItemDetails.GetItemDetailsId(entity.ItemDetailsId),
                StoredProcedures.ItemDetails.GetItemId(entity.ItemId),
                StoredProcedures.ItemDetails.GetSpecifications(entity.Specifications)
            };
            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.ItemDetails.Insert, pm.ToArray());
                con.Close();
            }

        }

        public IEnumerable<ItemDetails> GetAll()
        {
            List<ItemDetails> itemdetails = new List<ItemDetails>();

            List<SqlParameter> ps = new List<SqlParameter>();
            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.ItemDetails.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        itemdetails.Add(ExtractRow(r));
                }
            }

            return itemdetails;

        }

        private static ItemDetails ExtractRow(DataRow r)
        {
            var idid = r["ItemDetailsId"];
            var iid = r["ItemId"];
            var s = r["Specifications"];

            return new ItemDetails()
            {
                ItemDetailsId = Convert.ToInt64(idid),
                ItemId = Convert.ToInt64(iid),
                Specifications = DBNull.Value.Equals(s) ? null : Convert.ToString(s)
            };

        }

        public ItemDetails GetById(long id)
        {
            ItemDetails p = new ItemDetails();
            List<SqlParameter> ps = new()
            {
                StoredProcedures.ItemDetails.GetItemDetailsId(id)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.ItemDetails.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        p = ExtractRow(r);
                }
            }

            return p;

        }


        // not confirmed 
        public void Remove(ItemDetails entity)
        {
            List<SqlParameter> ps = new()
            {
                StoredProcedures.ItemDetails.GetItemDetailsId(entity.ItemDetailsId),
                StoredProcedures.ItemDetails.GetItemId(entity.ItemId)
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.ItemDetails.Delete, ps.ToArray());
                con.Close();
            }

        }

        public void Update(ItemDetails entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.ItemDetails.GetItemDetailsId(entity.ItemDetailsId),
                StoredProcedures.ItemDetails.GetItemId(entity.ItemId),         
                StoredProcedures.ItemDetails.GetSpecifications(entity.Specifications)
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.ItemDetails.Update, pm.ToArray());
                con.Close();
            }
        }


    }

}
