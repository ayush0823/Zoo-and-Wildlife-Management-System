from django.db import connection
import numpy as np
from django.shortcuts import render
from wildlife_db.models import zooModel, mrModel
import messages
from django.contrib import messages
from wildlife_db.forms import zooForm, mrForm
from django.shortcuts import redirect
from tabulate import tabulate
import webbrowser

def index(request):
    return render(request,'index.html')

def index_in(request):
    return render(request,'index_in.html')

def login(request):
    return render(request,'login.html')

def z_crud(request):
    showall=zooModel.objects.all()
    if request.method=="POST":
        if request.POST.get('sort'):
            type=request.POST.get('sort')
            sorted=zooModel.objects.all().order_by(type)
            return render(request,'z_crud.html',{"data":sorted})
    else:
        return render(request,'z_crud.html',{"data":showall})
    return render(request,'z_crud.html',{"data":showall})

def z_view(request):
    showall=zooModel.objects.all()
    if request.method=="POST":
        if request.POST.get('sort'):
            type=request.POST.get('sort')
            sorted=zooModel.objects.all().order_by(type)
            return render(request,'z_view.html',{"data":sorted})
    else:
        return render(request,'z_view.html',{"data":showall})
    return render(request,'z_view.html',{"data":showall})

def z_create(request):
    if request.method=="POST":
        if request.POST.get('z_id') and request.POST.get('name') and request.POST.get('s_id') and request.POST.get('area_covered'):
            saverecord=zooModel()
            saverecord.z_id=request.POST.get('z_id')
            saverecord.name=request.POST.get('name')
            saverecord.s_id=request.POST.get('s_id')
            saverecord.area_covered=request.POST.get('area_covered')

            allzoo=zooModel.objects.all()

            for i in allzoo:
                if int(i.z_id)==int(request.POST.get('z_id')):
                    messages.warning(request,'id already exist...')
                    return render(request,'z_create.html')

            saverecord.save()
            try:
                messages.success(request,'zoo '+saverecord.name+' is saved successfully...')
            except:
                messages.warning(request,'s_id not already exist...')
                return render(request,'z_create.html')

            return render(request,'z_create.html')
        else:
            return render(request,'z_create.html')
    return render(request,'z_create.html')

def z_edit(request,z_id):
    edit_z=zooModel.objects.get(z_id=z_id)
    return render(request,'z_edit.html',{"zooModel":edit_z})

def z_update(request,z_id):
    update_z=zooModel.objects.get(z_id=z_id)
    form=zooForm(request.POST,instance=update_z)
    if form.is_valid():
        form.save()
        messages.success(request,'record updated successfully....')
        return render(request,'z_edit.html',{"zooModel":update_z})

def z_delete(request,z_id):
    delete_z=zooModel.objects.get(z_id=z_id)
    return render(request,'z_delete.html',{"data":delete_z})

def z_afterdelete(request,z_id):
    delete_z=zooModel.objects.get(z_id=z_id)
    id_z=request.POST.get('z_id')
    delete_z.delete()
    messages.success(request,'z_id '+id_z+' record deletion successful...')
    return render(request,'z_delete.html',{"data":delete_z})

# display all info of zoo in descending order of area_covered where area_covered is greater than equal to avg area_covered
def z_query(request):
    query='select * from zoo where area_covered>=(select avg(area_covered) from zoo) order by area_covered desc'

    cur=connection.cursor()
    cur.execute(query)
    data=cur.fetchall()

    return render(request,'z_query.html',{"data":data})

# display all info of migration record where source is zoo and also print name of zoo, area_covered, z_id, s_id
def mr_query(request):
    query='select * from migration_record inner join zoo on migration_record.source_id=zoo.z_id'

    cur=connection.cursor()
    cur.execute(query)
    data=cur.fetchall()

    return render(request,'mr_query.html',{"data":data})

def signin(request):
    if request.method=='POST':
        username=request.POST.get('username')
        password=request.POST.get('password')
        if username=="admin" and password=="admin":
            return redirect('index_in')
        else:
            return redirect('login')
    else:
        return redirect('index_in')

def custom_query(request):
    query=request.POST.get('custom_query')
    if query!=None:
        cur=connection.cursor()
        try:
            cur.execute(query)
        except:
            messages.warning(request,'invalid query')
            return render(request,'custom_query.html')
            
        data=cur.fetchall()
        colums=tuple([desc[0] for desc in cur.description])
        table=tabulate(data,headers=colums,tablefmt="html")

        messages.success(request,'output is in new tab...')

        f=open("run_query.html","w")
        f.write(table)
        f.close()
        webbrowser.open_new_tab("run_query.html")
        return render(request,'custom_query.html')
    return render(request,'custom_query.html')

def mr_crud(request):
    showall=mrModel.objects.all()
    if request.method=="POST":
        if request.POST.get('sort'):
            type=request.POST.get('sort')
            sorted=mrModel.objects.all().order_by(type)
            return render(request,'mr_crud.html',{"data":sorted})
    else:
        return render(request,'mr_crud.html',{"data":showall})
    return render(request,'mr_crud.html',{"data":showall})

def mr_create(request):
    if request.method=="POST":
        if request.POST.get('mr_id') and request.POST.get('source_id') and request.POST.get('destination_id') and request.POST.get('animal_id') and request.POST.get('animal_count') and request.POST.get('reason'):

            saverecord=mrModel()
            saverecord.mr_id=request.POST.get('mr_id')
            saverecord.source_id=request.POST.get('source_id')
            saverecord.destination_id=request.POST.get('destination_id')
            saverecord.animal_id=request.POST.get('animal_id')
            saverecord.animal_count=request.POST.get('animal_count')
            saverecord.reason=request.POST.get('reason')

            allmr=mrModel.objects.all()

            for i in allmr:
                if int(i.mr_id)==int(request.POST.get('mr_id')):
                    messages.warning(request,'id already exist...')
                    return render(request,'mr_create.html')

            saverecord.save()
            try:
                messages.success(request,'migration record '+saverecord.mr_id+' is saved successfully...')
            except:
                messages.warning(request,'foreign key constraint violation')
                return render(request,'mr_create.html')

            return render(request,'mr_create.html')
        else:
            return render(request,'mr_create.html')
    return render(request,'mr_create.html')

def mr_edit(request,mr_id):
    edit_mr=mrModel.objects.get(mr_id=mr_id)
    return render(request,'mr_edit.html',{"mrModel":edit_mr})

def mr_update(request,mr_id):
    update_mr=mrModel.objects.get(mr_id=mr_id)
    form=mrForm(request.POST,instance=update_mr)
    if form.is_valid():
        form.save()
        messages.success(request,'record updated successfully....')
        return render(request,'mr_edit.html',{"mrModel":update_mr})

def mr_delete(request,mr_id):
    delete_mr=mrModel.objects.get(mr_id=mr_id)
    return render(request,'mr_delete.html',{"data":delete_mr})

def mr_afterdelete(request,mr_id):
    delete_mr=mrModel.objects.get(mr_id=mr_id)
    id_mr=request.POST.get('mr_id')
    delete_mr.delete()
    messages.success(request,'mr_id '+id_mr+' record deletion successful...')
    return render(request,'mr_delete.html',{"data":delete_mr})
