import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing

print("Loading data...")
df=pd.read_csv('generated_csvs/df.csv')
df=df.drop('Unnamed: 0',axis=1)
df['gvv']=preprocessing.normalize([df['gvv'].values])[0]
df['ep_str']=preprocessing.normalize([df['ep_str'].values])[0]
df['ep_inst']=preprocessing.normalize([df['ep_inst'].values])[0]
df['rmfcc']=preprocessing.normalize([df['rmfcc'].values])[0]

print("Splitting data...")
X_train, X_test, y_train, y_test = train_test_split(df.drop('lang',axis=1), df['lang'], test_size=0.2, random_state=1)
X_val, X_test, y_val, y_test = train_test_split(X_test, y_test, test_size=0.5, random_state=1)

print("Decision Tree Classifier:")
print("Training model...")
clf = DecisionTreeClassifier().fit(X_train, y_train)

print("Making predictions...")
print('Accuracy of Decision Tree classifier on training set: {:.2f}'
     .format(clf.score(X_train, y_train)))
print('Accuracy of Decision Tree classifier on validation set: {:.2f}'
     .format(clf.score(X_val, y_val)))
print('Accuracy of Decision Tree classifier on test set: {:.2f}'
     .format(clf.score(X_test, y_test)))

print("Random Forest Classifier:")
print("Training model...")
clf = RandomForestClassifier().fit(X_train, y_train)

print("Making predictions...")
print('Accuracy of Random Forest classifier on training set: {:.2f}'
     .format(clf.score(X_train, y_train)))
print('Accuracy of Random Forest classifier on validation set: {:.2f}'
     .format(clf.score(X_val, y_val)))
print('Accuracy of Random Forest classifier on test set: {:.2f}'
     .format(clf.score(X_test, y_test)))
