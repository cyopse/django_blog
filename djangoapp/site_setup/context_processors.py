# pylint: disable=missing-module-docstring,missing-class-docstring,missing-function-docstring
from site_setup.models import SiteSetup


def site_setup(request):
    setup = SiteSetup.objects.order_by(  # pylint: disable=no-member
        '-id').first()

    return {
        'site_setup': setup,
    }
