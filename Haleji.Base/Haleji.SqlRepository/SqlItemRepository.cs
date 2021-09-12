using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using Irada.Common.DAL;
using System.Data;
using System.Data.SqlClient;

namespace Haleji.SqlRepository
{
    public class SqlItemRepository : IItemRepository
    {
        const string ItemId = "ItemId";
        const string ItemName = "ItemName";
        const string ItemDescr = "Description";
        private string _constr = SQLHelper.ConnectionString;

        private static Item ExtractRow(DataRow r)
        {
            return new Item()
            {
                ItemId = Convert.ToInt64(r[ItemId]),
                ItemName = Convert.ToString(r[ItemName]),
                Description = Convert.ToString(r[ItemDescr])
            };
        }

        public void Add(Item entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Item.GetItemName(entity.ItemName));
            ps.Add(StoredProcedures.Item.GetItemDescr(entity.Description));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                var r = SQLHelper.ExecuteScalar(con, StoredProcedures.Item.Insert, ps.ToArray());
                con.Close();

                entity.ItemId = Convert.ToInt64(r);
            }

        }

        public IEnumerable<Item> GetAll()
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            List<Item> items = new List<Item>();

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Item.GetAll, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        items.Add(ExtractRow(r));
                    }
                }
            }

            return items;
        }

        public Item GetById(long id)
        {
            Item found = new Item();
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Item.GetItemId(id));


            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Item.Search, ps.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        found = ExtractRow(r);
                    }
                }
            }

            return found;
        }

        public void Remove(Item entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Item.GetItemId(entity.ItemId));


            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Item.Delete, ps.ToArray());
                con.Close();
            }
        }

        public void Update(Item entity)
        {
            List<SqlParameter> ps = new List<SqlParameter>();
            ps.Add(StoredProcedures.Item.GetItemId(entity.ItemId));
            ps.Add(StoredProcedures.Item.GetItemName(entity.ItemName));
            ps.Add(StoredProcedures.Item.GetItemDescr(entity.Description));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Item.Update, ps.ToArray());
                con.Close();
            }
        }
    }
}
