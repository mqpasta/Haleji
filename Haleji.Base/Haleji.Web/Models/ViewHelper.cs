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
    }

    
}
