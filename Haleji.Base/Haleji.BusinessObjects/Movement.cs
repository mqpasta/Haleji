using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Movement : IEntity
    {
        [DisplayName("Movement ID")]
        [Key]
        public long MovementId { get; set; }

        [DisplayName("Status")]
        [Required]
        public long TransactionTypeId { get; set; }

        [DisplayName("Person")]
        public long? PersonId { get; set; }
        public string? PersonName { get; set; }

        [DisplayName("Location")]
        public long? LocationId { get; set; }

        public string LocationName { get; set; }

        [DisplayName("Purchase Order")]
        public long? PurchaseId { get; set; }

        [DisplayName("Item")]
        public string? ItemName { get; set; }

        [DisplayName("Date")]
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime MovDate { get; set; }

        [DisplayName("Status")]
        [Required]
        public bool IsActive { get; set; }

        [DisplayName("Details")]
        public long? ParentMovementId { get; set; }

        public long Key
        {
            get { return this.MovementId; }
            set { }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Movement), entity, this);
        }
    }
}
