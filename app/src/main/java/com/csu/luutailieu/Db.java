package com.csu.luutailieu;
import android.content.*; import android.database.*; import android.database.sqlite.*; import java.util.*;
public class Db extends SQLiteOpenHelper {
 public Db(Context c){super(c,"csu.db",null,1);} public void onCreate(SQLiteDatabase d){d.execSQL("CREATE TABLE devices(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,location TEXT,related TEXT)");} public void onUpgrade(SQLiteDatabase d,int a,int b){}
 public long add(){ContentValues v=new ContentValues();v.put("name","Thiết bị mới");v.put("location","");v.put("related","");return getWritableDatabase().insert("devices",null,v);}
 public void save(long id,String n,String l,String r){ContentValues v=new ContentValues();v.put("name",n);v.put("location",l);v.put("related",r);getWritableDatabase().update("devices",v,"id=?",new String[]{""+id});}
 public void del(long id){getWritableDatabase().delete("devices","id=?",new String[]{""+id});}
 public ArrayList<Item> list(String q){ArrayList<Item>a=new ArrayList<>();String like="%"+q+"%";Cursor c=getReadableDatabase().rawQuery("SELECT id,name,location,related FROM devices WHERE name LIKE ? OR location LIKE ? OR related LIKE ? ORDER BY id DESC",new String[]{like,like,like});while(c.moveToNext())a.add(new Item(c.getLong(0),c.getString(1),c.getString(2),c.getString(3)));c.close();return a;}
 public static class Item{long id;String name,location,related;Item(long i,String n,String l,String r){id=i;name=n;location=l;related=r;}}
}
