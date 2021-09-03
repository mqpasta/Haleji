using System;
using System.Collections.Generic;

using Haleji.BusinessObjects;

namespace Haleji.RepositoryBase
{
    public interface IGenericRepository<T> where T: class
    {
        T GetById(long id);

        IEnumerable<T> GetAll();

        void Add(T entity);

        void Update(T entity);

        void Remove(T entity);

    }
    
}
