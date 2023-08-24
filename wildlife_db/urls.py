"""wildlife_db URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path('',views.index,name="index"),
    path('index',views.index,name="index"),

    path('login',views.login,name="login"),
    path('signin',views.signin,name="signin"),
    path('index_in',views.index_in,name="index_in"),

    path('z_view',views.z_view,name="z_view"),
    path('z_crud',views.z_crud,name="z_crud"),
    path('z_create',views.z_create,name="z_create"),
    path('z_edit/<int:z_id>',views.z_edit,name="z_edit"),
    path('z_update/<int:z_id>',views.z_update,name="z_update"),
    path('z_delete/<int:z_id>',views.z_delete,name="z_delete"),
    path('z_afterdelete/<int:z_id>',views.z_afterdelete,name="z_afterdelete"),
    path('z_query',views.z_query,name="z_query"),

    path('mr_crud',views.mr_crud,name="mr_crud"),
    path('mr_create',views.mr_create,name="mr_create"),
    path('mr_edit/<int:mr_id>',views.mr_edit,name="mr_edit"),
    path('mr_update/<int:mr_id>',views.mr_update,name="mr_update"),
    path('mr_delete/<int:mr_id>',views.mr_delete,name="mr_delete"),
    path('mr_afterdelete/<int:mr_id>',views.mr_afterdelete,name="mr_afterdelete"),
    path('mr_query',views.mr_query,name="mr_query"),

    path('custom_query',views.custom_query,name="custom_query"),
]
