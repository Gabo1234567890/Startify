from django.http import JsonResponse
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt  # Disable CSRF for Postman testing (use authentication in production)
def delete_all_users(request):
    if request.method == "DELETE":
        try:
            User.objects.all().delete()
            return JsonResponse({"message": "All users have been deleted successfully."}, status=200)
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)
    return JsonResponse({"error": "Invalid request method"}, status=400)
