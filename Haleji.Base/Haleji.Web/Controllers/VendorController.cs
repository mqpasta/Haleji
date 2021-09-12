using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Haleji.Web.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Haleji.Web.Controllers
{
    public class VendorController : Controller
    {
        IRepositoryFactory _factory;

        public VendorController(IRepositoryFactory factory)
        {
            _factory = factory;
        }
        // GET: VendorController
        public ActionResult Index()
        {
            return View(_factory.VendorRepository.GetAll());
        }

        // GET: VendorController/Create
        public ActionResult Create()
        {
            return PartialView(ViewHelper.CREATE_PARTIAL);
        }

        // POST: VendorController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Vendor v)
        {
            if (ModelState.IsValid)
            {
                _factory.VendorRepository.Add(v);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.CREATE_PARTIAL, v);
            }
        }

        // GET: VendorController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.VendorRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: VendorController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Vendor v)
        {
            if (ModelState.IsValid)
            {
                _factory.VendorRepository.Update(v);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, v);
            }
        }

        // GET: VendorController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.VendorRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: VendorController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Vendor v)
        {
            if (v != null && v.Key > 0)
            {
                _factory.VendorRepository.Remove(v);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, v);
            }
        }
    }
}
