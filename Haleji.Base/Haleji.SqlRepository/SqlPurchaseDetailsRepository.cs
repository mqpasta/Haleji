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
    public class SqlPurchaseDetailsRepository : IPurchaseDetailsRepository
    {
        private readonly string _constr = SQLHelper.ConnectionString;

        public void Add(PurchaseDetails entity)
        {
            List<SqlParameter> pm = new()
            {
                /*StoredProcedures.PurchaseDetails.GetPurchaseDetailsId(entity.PurchaseDetailsId),*/
                StoredProcedures.PurchaseDetails.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.PurchaseDetails.GetItemDetailsID(entity.ItemDetailsId),
                StoredProcedures.PurchaseDetails.GetDescription(entity.Description)
                
            };
            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.PurchaseDetails.Insert, pm.ToArray());
                con.Close();
            }

        }

        public IEnumerable<PurchaseDetails> GetAll()
        {
            List<PurchaseDetails> purchasedetails = new List<PurchaseDetails>();

            List<SqlParameter> ps = new List<SqlParameter>();
            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.PurchaseDetails.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        purchasedetails.Add(ExtractRow(r));
                }
            }

            return purchasedetails;

        }

        private static PurchaseDetails ExtractRow(DataRow r)
        {
            var pdid = r["PurchaseDetailsId"];
            var pid = r["PurchaseId"];
            var idid = r["ItemDetailsId"];
            var d = r["Description"];

            return new PurchaseDetails()
            {
                PurchaseDetailsId = Convert.ToInt64(pdid),
                PurchaseId = Convert.ToInt64(pid),
                ItemDetailsId = Convert.ToInt64(idid),
                Description = DBNull.Value.Equals(d) ? null : Convert.ToString(d)
            };

        }

        public PurchaseDetails GetById(long id)
        {
            PurchaseDetails p = new PurchaseDetails();
            List<SqlParameter> ps = new()
            {
                StoredProcedures.PurchaseDetails.GetPurchaseDetailsId(id)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.PurchaseDetails.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        p = ExtractRow(r);
                }
            }

            return p;

        }

        public void Remove(PurchaseDetails entity)
        {
            List<SqlParameter> ps = new()
            {
                StoredProcedures.PurchaseDetails.GetPurchaseId(entity.PurchaseId)
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.PurchaseDetails.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(PurchaseDetails entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.PurchaseDetails.GetPurchaseDetailsId(entity.PurchaseDetailsId),
                StoredProcedures.PurchaseDetails.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.PurchaseDetails.GetItemDetailsID(entity.ItemDetailsId),
                StoredProcedures.PurchaseDetails.GetDescription(entity.Description)
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.PurchaseDetails.Update, pm.ToArray());
                con.Close();
            }
        }


    }

}
