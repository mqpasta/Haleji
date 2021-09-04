using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Vendor : IEntity
    {
        [DisplayName("Vendor Id")]
        [Key]
        public long VendorId { get; set; }

        [DisplayName("Vendor Name")]
        [MaxLength(200, ErrorMessage ="Maximum limit is 200 characters.")]
        [Required]
        public string VendorName { get; set; }

        [DisplayName("Address")]
        [MaxLength(500, ErrorMessage ="Maximum limit is 500 characters.")]
        public string Address { get; set; }

        [DisplayName("Contact Person")]
        [MaxLength(200, ErrorMessage = "Maximum limit is 200 characters.")]
        public string ContactPerson { get; set; }

        [DisplayName("Contact Number")]
        [MaxLength(50, ErrorMessage = "Maximum limit is 50 characters.")]
        public string Contact { get; set; }

        [DisplayName("Note")]
        [MaxLength(1000, ErrorMessage = "Maximum limit is 1000 characters.")]
        public string Note { get; set; }

        public long Key
        {
            get { return this.VendorId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Item), entity, this);
        }
    }
}
