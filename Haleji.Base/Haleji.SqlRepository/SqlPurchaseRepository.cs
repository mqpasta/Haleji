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
    public class SqlPurchaseRepository : IPurchaseRepository
    {
        private readonly string _constr = SQLHelper.ConnectionString;
        public void Add(Purchase entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Purchase.GetItemId(entity.ItemId),
                StoredProcedures.Purchase.GetVendorId(entity.VendorId),
                StoredProcedures.Purchase.GetPurchaseDate(entity.PurchaseDate),
                StoredProcedures.Purchase.GetStartDate(entity.StartDate),
                StoredProcedures.Purchase.GetEndDate(entity.EndDate),
                StoredProcedures.Purchase.GetPONumber(entity.PONumber),
                StoredProcedures.Purchase.GetInvoiceNumber(entity.InvoiceNumber),
                StoredProcedures.Purchase.GetDescription(entity.Description),
                StoredProcedures.Purchase.GetTagNo(entity.TagNo),
                StoredProcedures.Purchase.GetTransType(Convert.ToInt32(entity.CurrentTransType))
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Purchase.Insert, pm.ToArray());
                con.Close();
            }
        }

        public IEnumerable<Purchase> GetAll()
        {
            List<Purchase> purchases = new List<Purchase>();

            List<SqlParameter> ps = new List<SqlParameter>();
            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Purchase.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        purchases.Add(ExtractRow(r));
                }
            }

            return purchases;
        }

        private static Purchase ExtractRow(DataRow r)
        {
            var pid = r["PurchaseId"];
            var iid = r["ItemId"];
            var vid = r["VendorId"];
            var iname = r["ItemName"];
            var vname = r["VendorName"];
            var pd = r["PurchaseDate"];
            var sd = r["StartDate"];
            var ed = r["EndDate"];
            var po = r["PONumber"];
            var io = r["InvoiceNumber"];
            var d = r["Description"];
            var t = r["TagNo"];
            var ct = r["CurrentTransType"];

            return new Purchase()
            {
                PurchaseId = Convert.ToInt64(pid),
                ItemId = Convert.ToInt64(iid),
                VendorId = Convert.ToInt64(vid),
                ItemName = Convert.ToString(iname),
                VendorName = Convert.ToString(vname),
                PurchaseDate = Convert.ToDateTime(pd),
                StartDate = DBNull.Value.Equals(sd) ? null : Convert.ToDateTime(sd),
                EndDate = DBNull.Value.Equals(ed) ? null : Convert.ToDateTime(ed),
                PONumber = DBNull.Value.Equals(po) ? null : Convert.ToString(po),
                InvoiceNumber = DBNull.Value.Equals(io) ? null : Convert.ToString(io),
                Description = DBNull.Value.Equals(d) ? null : Convert.ToString(d),
                TagNo = Convert.ToString(t),
                CurrentTransType = DBNull.Value.Equals(ct) ? null : Convert.ToInt64(ct)
            };
        }

        public Purchase GetById(long id)
        {
            Purchase p = new Purchase();
            List<SqlParameter> ps = new()
            {
                StoredProcedures.Purchase.GetPurchaseId(id)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Purchase.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        p = ExtractRow(r);
                }
            }

            return p;
        }

        public void Remove(Purchase entity)
        {
            List<SqlParameter> ps = new()
            {
                StoredProcedures.Purchase.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.Purchase.GetTransType(StoredProcedures.TransType.InStock)
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Purchase.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(Purchase entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Purchase.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.Purchase.GetItemId(entity.ItemId),
                StoredProcedures.Purchase.GetVendorId(entity.VendorId),
                StoredProcedures.Purchase.GetPurchaseDate(entity.PurchaseDate),
                StoredProcedures.Purchase.GetStartDate(entity.StartDate),
                StoredProcedures.Purchase.GetEndDate(entity.EndDate),
                StoredProcedures.Purchase.GetPONumber(entity.PONumber),
                StoredProcedures.Purchase.GetInvoiceNumber(entity.InvoiceNumber),
                StoredProcedures.Purchase.GetDescription(entity.Description),
                StoredProcedures.Purchase.GetTagNo(entity.TagNo),
                StoredProcedures.Purchase.GetTransType(Convert.ToInt32(entity.CurrentTransType))
            };

            using (SqlConnection con = new(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Purchase.Update, pm.ToArray());
                con.Close();
            }
        }

        public List<Purchase> GetByTransactionType(long transType)
        {
            List<Purchase> purchases = new();
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Purchase.GetTransType(transType)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Purchase.Search, pm.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        purchases.Add(ExtractRow(r));
                }
            }

            return purchases;
        }
    }
}
