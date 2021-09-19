﻿using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Haleji.Web.Models;
using Haleji.RepositoryBase;
using Haleji.BusinessObjects;

namespace Haleji.Web.Controllers
{
    public class ReportController : Controller
    {
        IRepositoryFactory _factory;

        public ReportController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Issued(ReportIssued r)
        {
            var p = ViewHelper.PersonList(_factory, r.PersonId);
            var l = ViewHelper.LocationList(_factory, r.LocationId);
            
            ViewBag.PersonList = p;
            ViewBag.LocationList = l;

            Movement m = new();
            if (r.PersonId != -1)
                m.PersonId = r.PersonId;
            if (r.LocationId != -1)
                m.LocationId = r.LocationId;
            m.TransactionTypeId = (int)TransactionType.Issued;
            m.IsActive = true;

            r.Result = _factory.MovementRepository.SearchMovement(m, r.StartDate, r.EndDate);
            
            return View(r);
        }

        public IActionResult StockSummary(ReportStockSummary s)
        {
            if (s == null)
                s = new ReportStockSummary();

            s.Result = _factory.ItemRepository.GetStockSummary();

            return View(s);
        }
    }
}
