using System.Web.Mvc;

namespace ioschoolsWebsite.Controllers
{
    public class dummyController : Controller
    {
        //
        // GET: /dummy/

        public ActionResult Index()
        {
            return new EmptyResult();
        }

    }
}
