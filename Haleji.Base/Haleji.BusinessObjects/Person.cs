using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Person : IEntity
    {
        [DisplayName("Person ID")]
        [Key]
        public long PersonId { get; set; }

        [DisplayName("Department Name")]
        public long? DepartmentId { get; set; }

        [DisplayName("Department")]
        public string? DepartmentName { get; set; }

        [DisplayName("Name")]
        [MaxLength(200, ErrorMessage ="Maximum limit is 200 characters.")]
        [Required]
        public string Name { get; set; }

        [DisplayName("Ext. Number")]
        [MaxLength(100, ErrorMessage ="Maximum limit is 100 characters.")]
        public string? Ext { get; set; }
        
        [DisplayName("Contact Number")]
        [MaxLength(100, ErrorMessage ="Maximum limit is 100 characters.")]
        public string? Contact { get; set; }

        [DisplayName("Active")]
        [Required]
        public bool IsActive { get; set; }

        public long Key
        {
            get { return this.PersonId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Person), entity, this);
        }


    }
}
