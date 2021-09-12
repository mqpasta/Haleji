using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using Haleji.Web.Models;

namespace Haleji.Web.Controllers
{
    public class DepartmentController : Controller
    {
        IRepositoryFactory _factory;
        public DepartmentController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: DepartmentController
        public ActionResult Index()
        {
            return View(_factory.DepartmentRepository.GetAll());
        }

        // GET: DepartmentController/Create
        public ActionResult Create()
        {
            return PartialView(ViewHelper.CREATE_PARTIAL);
        }

        // POST: DepartmentController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Department d)
        {
            if (ModelState.IsValid)
            {
                _factory.DepartmentRepository.Add(d);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.CREATE_PARTIAL, d);
            }
        }

        // GET: DepartmentController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.DepartmentRepository.GetById(id);
            if (found != null)
                return PartialView(ViewHelper.EDIT_PARTIAL, found);
            else
                return BadRequest();

        }

        // POST: DepartmentController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Department d)
        {
            if(ModelState.IsValid)
            {
                _factory.DepartmentRepository.Update(d);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, d);
            }
        }

        // GET: DepartmentController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.DepartmentRepository.GetById(id);
            if(found!=null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: DepartmentController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Department d)
        {
            if(ModelState.IsValid)
            {
                _factory.DepartmentRepository.Remove(d);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, d);
            }
            
        }
    }
}
