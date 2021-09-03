using System;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using System.Transactions;
using System.Collections.Generic;

namespace Haleji.BusinessLogic
{
    public class LocationService
    {
        private IRepositoryFactory _factory;


        public LocationService(IRepositoryFactory factory)
        {
            _factory = factory;

        }

        public List<Location> GetAllLocations()
        {
            return (List<Location>)_factory.LocationRepository.GetAll();
        }

        public void CreateLocation(Location l)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                _factory.LocationRepository.Add(l);
            }
        }

    }

}

