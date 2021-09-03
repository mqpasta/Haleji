using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Location : IEntity
    {
        [DisplayName("Location Id")]
        [Key]
        public long LocationId { get; set; }

        [DisplayName("Name")]
        [MaxLength(50,ErrorMessage ="Maximum characters limit is 50.")]
        [Required]
        public string LocationName { get; set; }

        public long Key
        {
            get { return this.LocationId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Location), entity, this);
        }
    }
}
