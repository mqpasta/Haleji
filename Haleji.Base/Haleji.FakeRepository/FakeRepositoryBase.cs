using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using System.Data;

namespace Haleji.FakeRepository
{
    public abstract class FakeRepositoryBase<T> where T : IEntity
    {
        private List<T> _entites;

        public FakeRepositoryBase()
        {
            _entites = new List<T>();

        }
        public void Add(T entity)
        {
            _entites.Add(entity);
        }

        public IEnumerable<T> GetAll()
        {
            return _entites;

        }

        public T GetById(long id)
        {
            return _entites.Find(x => x.Key == id);
        }

        public void Remove(T entity)
        {
            _entites.Remove(entity);
        }

        public void Update(T entity)
        {
            var found = GetById(entity.Key);
            found.Update(entity);
        }
    }

    public class ItemRepository : FakeRepositoryBase<Item>, IItemRepository
    {
        public DataTable GetStockSummary()
        {
            throw new NotImplementedException();
        }
    }

    public class DepartmentRepository : FakeRepositoryBase<Department>, IDepartmentRepository
    {

    }
}
