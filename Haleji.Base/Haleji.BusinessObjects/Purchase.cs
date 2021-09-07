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
        public long ItemId { get; set; }
        [DisplayName("Item")]
        public string ItemName { get; set; }

        [DisplayName("Vendor")]
        [Required]
        public long VendorId { get; set; }

        [DisplayName("Vendor")]
        public string VendorName { get; set; }

        [DisplayName("Purchase Date")]
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime PurchaseDate { get; set; }

        [DisplayName("Warranty")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime? StartDate { get; set; }

        [DisplayName("Warranty End Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime? EndDate { get; set; }

#nullable enable
        [DisplayName("PO Number")]
        public string? PONumber { get; set; }

        [DisplayName("Invoice Number")]
        public string? InvoiceNumber { get; set; }

        [DisplayName("Description")]
        public string? Description { get; set; }
#nullable disable

        [DisplayName("Tag Number")]
        [Required]
        public string TagNo { get; set; }

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
