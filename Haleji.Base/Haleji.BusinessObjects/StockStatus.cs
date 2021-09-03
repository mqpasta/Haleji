using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class StockStatus : IEntity
    {
        [DisplayName("Item")]
        public Item Item { get; set; }

        [DisplayName("Transaction Type")]
        public TransType TransactionType { get; set; }

        [DisplayName("Count")]
        public int Count { get; set; }

        public long Key
        {
            get { return this.Item.ItemId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Item), entity, this);
        }
    }
}
