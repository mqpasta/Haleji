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
    public class LocationController : Controller
    {
        IRepositoryFactory _factory;


        public LocationController(IRepositoryFactory factory)
        {
            _factory = factory;
        }
        // GET: LocationController
        public ActionResult Index()
        {
            return View(_factory.LocationRepository.GetAll());
        }

        // GET: LocationController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: LocationController/Create
        public ActionResult Create()
        {
            return PartialView(ViewHelper.CREATE_PARTIAL);
        }

        // POST: LocationController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Location l)
        {
            if(ModelState.IsValid)
            {
                _factory.LocationRepository.Add(l);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.CREATE_PARTIAL, l);
            }
        }

        // GET: LocationController/Edit/5
        public ActionResult Edit(int id)
        {
            Location l = _factory.LocationRepository.GetById(id);
            return PartialView(ViewHelper.EDIT_PARTIAL, l);
        }

        // POST: LocationController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Location location)
        {
            if (ModelState.IsValid)
            {
                _factory.LocationRepository.Update(location);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, location);
            }

        }

        // GET: LocationController/Delete/5
        public ActionResult Delete(int id)
        {
            Location found = _factory.LocationRepository.GetById(id);
            if (found != null)
                return PartialView(ViewHelper.DELETE_PARTIAL, found);

            return RedirectToAction(nameof(Index));
        }

        // POST: LocationController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Location location)
        {
            try
            {
                Location found = _factory.LocationRepository.GetById(location.LocationId);
                _factory.LocationRepository.Remove(found);
                return NoContent();
            }
            catch
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, location);
            }
        }
    }
}
