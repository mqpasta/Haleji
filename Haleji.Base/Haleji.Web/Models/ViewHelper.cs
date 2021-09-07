using Haleji.RepositoryBase;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Haleji.Web.Models
{
    public static class ViewHelper
    {
        public static readonly string CREATE_PARTIAL = "_CreatePartial";
        public static readonly string DELETE_PARTIAL = "_DeletePartial";
        public static readonly string EDIT_PARTIAL = "_EditPartial";

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
    }


}
