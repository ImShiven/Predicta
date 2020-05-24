using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Predicta.Startup))]
namespace Predicta
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
