using System;
using System.Collections.Generic;
using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using System.Data;
using System.Data.SqlClient;

namespace Haleji.FakeRepository
{
    public class FakeLocationRepository : ILocationRepository
    {
        static List<Location> _entities;

        public FakeLocationRepository()
        {
            _entities = new List<Location>();
            _entities.Add(new Location()
            {
                LocationId = 1,
                LocationName = "New Location"
            });
        }
        public void Add(Location entity)
        {
            _entities.Add(entity);
        }

        public void AddRange(IEnumerable<Location> entities)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Location> GetAll()
        {
            return _entities;
        }

        public Location GetById(long id)
        {
            return _entities.Find(x => x.LocationId == id);
        }

        public void Remove(Location entity)
        {
            _entities.Remove(entity);
        }

        public void RemoveRange(IEnumerable<Location> entities)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Location> SearchByName(string name)
        {
            throw new NotImplementedException();
        }

        public void Update(Location entity)
        {
            Location found = GetById(entity.LocationId);
            if(found != null)
            {
                found.LocationName = entity.LocationName;
            }
        }
    }

    
}
