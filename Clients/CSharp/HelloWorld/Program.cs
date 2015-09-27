using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Runtime.InteropServices;

namespace HelloWorld
{
    class Program
    {
        [DllImport("C:\\Users\\erik\\Documents\\repos\\reposit\\quantlib\\QuantLibAddin2\\Release (static runtime)\\AddinCSharp.dll", CharSet = CharSet.Ansi, CallingConvention = CallingConvention.StdCall)]
        [return: MarshalAs(UnmanagedType.LPStr)]
        public static extern string qlVersion();

        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            string qlv = qlVersion();
            Console.WriteLine("QuantLib version = " + qlv);
        }
    }
}
