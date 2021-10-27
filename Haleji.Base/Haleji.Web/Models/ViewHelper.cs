using Haleji.RepositoryBase;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Haleji.Web.Models
{
    public enum TransactionType
    {
        Available = 1,
        Issued = 2,
        Scrapped = 3,
        Discarded = 4,
        Received = 5
    }
    public static class ViewHelper
    {
        public static readonly string CREATE_PARTIAL = "_CreatePartial";
        public static readonly string DELETE_PARTIAL = "_DeletePartial";
        public static readonly string EDIT_PARTIAL = "_EditPartial";
        // for view
        public static readonly string VIEW_PARTIAL = "_ViewPartial";

        public static SelectList DepartmentList(IRepositoryFactory _factory, long? departmentId = null)
        {
            SelectList l;

            if (departmentId == null)
                l = new SelectList(_factory.DepartmentRepository.GetAll(),
                    "DepartmentId", "DepartmentName");
            else
                l = new SelectList(_factory.DepartmentRepository.GetAll(),
                    "DepartmentId", "DepartmentName", departmentId.Value);

            return l;
        }

        public static SelectList ItemList(IRepositoryFactory factory, long? itemId = null)
        {
            SelectList itemList;

            if (itemId == null)
                itemList = new SelectList(factory.ItemRepository.GetAll(),
                            "ItemId", "ItemName");
            else
                itemList = new SelectList(factory.ItemRepository.GetAll(),
                            "ItemId", "ItemName", itemId.Value);

            return itemList;
        }

        public static SelectList VendorList(IRepositoryFactory factory, long? vendorId = null)
        {
            SelectList vendrList;

            if (vendorId == null)
                vendrList = new SelectList(factory.VendorRepository.GetAll(),
                            "VendorId", "VendorName");
            else
                vendrList = new SelectList(factory.VendorRepository.GetAll(),
                            "VendorId", "VendorName", vendorId.Value);

            return vendrList;
        }

        public static SelectList PersonList(IRepositoryFactory factory, long? personId = null)
        {
            SelectList personList;

            if (personId == null)
            {
                var persons = factory.PersonRepository.GetAll();
                personList = new SelectList(persons,
                            "PersonId", "Name", "Select Person");
            }

            else
                personList = new SelectList(factory.PersonRepository.GetAll(),
                            "PersonId", "Name", personId.Value);

            return personList;
        }

        public static SelectList LocationList(IRepositoryFactory factory, long? locationId = null)
        {
            SelectList locationList;

            if (locationId == null)
                locationList = new SelectList(factory.LocationRepository.GetAll(),
                            "LocationId", "LocationName", "Select Location");
            else
                locationList = new SelectList(factory.LocationRepository.GetAll(),
                            "LocationId", "LocationName", locationId.Value);

            return locationList;
        }
    }


}
