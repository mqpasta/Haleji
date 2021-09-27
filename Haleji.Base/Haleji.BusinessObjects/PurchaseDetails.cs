using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class PurchaseDetails : IEntity
    {
        [DisplayName("Purchase Details ID")]
        [Key]
        public long PurchaseDetailsId { get; set; }

        [DisplayName("Purchase ID")]
        [Required]
        public long PurchaseId { get; set; }

        [DisplayName("Item Details ID")]
        [Required]
        public long ItemDetailsId { get; set; }

        [DisplayName("Product Description")]
        public string Description { get; set; }

        public long Key
        {
            get { return this.PurchaseDetailsId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(PurchaseDetails), entity, this);

        }
    }
}
