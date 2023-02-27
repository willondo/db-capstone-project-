#!/usr/bin/env python
# coding: utf-8

# In[1]:


get_ipython().system('pip install mysql-connector-python')


# In[2]:


import mysql.connector as connector


# In[ ]:


connection = connector.connect(user = "will.ondo", password = "mysql#27")


# In[ ]:


connection = connector.connect(user = "willondo", password = "mysql#27", db = "LittleLemonDB") 


# In[ ]:


show_tables_query = "SHOW tables" 
cursor.execute(show_tables_query)


# In[ ]:


print(results)


# In[ ]:


SELECT Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone, Orders.TotalCost 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.TotalCost > 60;

