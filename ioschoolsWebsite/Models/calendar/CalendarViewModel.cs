using System.Collections.Generic;
using ioschools.Data;
using ioschoolsWebsite.Library;

namespace ioschoolsWebsite.Models.calendar
{
    public class CalendarViewModel : BaseViewModel
    {
        public string calendar { get; set; }
        public IEnumerable<Pair<int,int>> months { get; set; }
        public Dictionary<int, IEnumerable<string>> time { get; set; } 

        public CalendarViewModel(BaseViewModel baseviewdata) : base(baseviewdata)
        {
            
        }
    }
}