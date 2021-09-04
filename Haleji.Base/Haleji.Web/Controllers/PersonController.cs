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
    public class PersonController : Controller
    {
        IRepositoryFactory _factory;

        public PersonController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: PersonController
        public ActionResult Index()
        {
            return View(_factory.PersonRepository.GetAll());
        }

        // GET: PersonController/Create
        public ActionResult Create()
        {
            ViewBag.DepartmentList = ViewHelper.DepartmentList(_factory);
            return PartialView(ViewHelper.CREATE_PARTIAL);
        }

        // POST: PersonController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Person p)
        {
            if (ModelState.IsValid)
            {
                _factory.PersonRepository.Add(p);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.CREATE_PARTIAL, p);
            }
        }

        // GET: PersonController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.PersonRepository.GetById(id);
            if (found != null)
            {
                ViewBag.DepartmentList = ViewHelper.DepartmentList(_factory);
                return PartialView(ViewHelper.EDIT_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: PersonController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Person p)
        {
            if (ModelState.IsValid)
            {
                _factory.PersonRepository.Update(p);
                return NoContent();
            }
            else
            {
                ViewBag.DepartmentList = ViewHelper.DepartmentList(_factory);
                return PartialView(ViewHelper.EDIT_PARTIAL, p);
            }
        }

        // GET: PersonController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.PersonRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: PersonController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Person p)
        {
            if (p != null && p.Key > 0)
            {
                _factory.PersonRepository.Remove(p);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, p);
            }
        }
    }
}
