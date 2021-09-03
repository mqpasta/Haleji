using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Department : IEntity
    {
        [DisplayName("Department ID")]
        [Key]
        public long DepartmentId { get; set; }

        [DisplayName("Department Name")]
        [MaxLength(50, ErrorMessage = "Maximum limit is 50 characters.")]
        [Required]
        public string DepartmentName { get; set; }
        public long Key
        {
            get
            {
                return DepartmentId;
            }
        }


        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Department), entity, this);
        }
    }
}
