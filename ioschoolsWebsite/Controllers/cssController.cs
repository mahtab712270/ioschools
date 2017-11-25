using System;
using System.Web;
using System.Web.Mvc;
using ioschoolsWebsite.Library;
using ioschoolsWebsite.Library.ActionFilters;

namespace ioschoolsWebsite.Controllers
{
    [ElmahError]
    public class cssController : Controller
    {
        public ActionResult all()
        {
            var csscontent = CssLoader.Instance.LoadFeatures("all.xml");
            Response.AddFileDependencies(csscontent.filenames.ToArray());
            Response.Cache.SetLastModifiedFromFileDependencies();
            Response.Cache.SetETagFromFileDependencies();
            Response.Cache.SetCacheability(HttpCacheability.Public);
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(30));
            Response.ContentType = "text/css";
            return Content(csscontent.content);
        }

    }
}
