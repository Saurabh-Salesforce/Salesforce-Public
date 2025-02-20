import { LightningElement,wire,api,track } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';		
import ACCOUNTNAME_FIELDS from '@salesforce/schema/Account.Name';
import getContacts from '@salesforce/apex/PracticeApex.getContacts';

const fields=[ACCOUNTNAME_FIELDS];
const columns=[{fieldName:'FirstName',label:'First Name',type:'text'},
							{fieldName:'LastName',label:'Last Name',type:'text'}];


export default class LWCConcepts extends LightningElement {
		
@api recordId;
 @track records;	
		columns=columns;
		mssg='The new mssg';

		
		constructor(){
				super();
				
				console.log('Inside the constructor',this.mssg);
				
		}
		
		connectedCallback(){
				console.log('Inside connected call back');
		}
		renderedCallback(){
				console.log('running when component is rendered');
				this.mssg='keep on changing';
		}

/*
		@wire(getContacts,{accId:'$recordId'})
		contactDetails({data,error}){
				console.log('In wire',JSON.stringify(data));
						this.records=data;
				
		}

*/
	async getContactsOnClick(){

		await getContacts({accId:this.recordId}).then(result=>{
			this.records=result;
			console.log('Printing inside the promise');
		}).catch(error=>{
			console.error('Some error happened');
		});

	}

	 async asyncAwaitTest(){

		await this.getContactsOnClick();
		console.log('Printing without waiting');

	}

		
		
		
		
}