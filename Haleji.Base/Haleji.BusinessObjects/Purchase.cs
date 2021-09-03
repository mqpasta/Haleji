using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Purchase : IEntity
    {
        [DisplayName("Purchase ID")]
        [Key]
        public long PurchaseId { get; set; }

        [DisplayName("Item")]
        [Required]
        public Item Item { get; set; }

        [DisplayName("Vendor")]
        [Required]
        public Vendor Vendor { get; set; }

        [DisplayName("Purchase Date")]
        [Required]
        public DateTime PurchaseDate { get; set; }

        [DisplayName("Warranty Start Date")]
        public DateTime StartDate { get; set; }

        [DisplayName("Warranty End Date")]
        public DateTime EndDate { get; set; }

        [DisplayName("Purchase Order Number")]
        public string PONumber { get; set; }

        [DisplayName("Invoice Number")]
        public string InvoiceNumber { get; set; }

        [DisplayName("Description")]
        public string Description { get; set; }

        public long Key
        {
            get { return this.PurchaseId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Purchase), entity, this);

        }
    }
}
