const app = Vue.createApp({
  data() {
    return {
      listExams: [],
      searchQuery: '',
    };
  },

  computed:{
    filteredExams(){

      if(this.searchQuery){

        return this.listExams.filter(contact => {

        return contact.resultToken.toLowerCase().includes(this.searchQuery.toLowerCase()); 

        });
      }else{
        return this.listExams;
      }
    }
  },

  methods: {
    async getData() {
      let response = await fetch('http://localhost:3000/tests');
      let data = await response.json();

      this.listExams = data.map((item) => {
        return {
          resultToken: item.result_token,
          resultDate: item.result_date,
          cpf: item.cpf,
          name: item.name,
          email: item.email,
          birthday: item.birthday,
          crm: item.doctor.crm,
          crm_state: item.doctor.crm_state,
          docName: item.doctor.name,
          tests: item.tests,
        };
      });
    },
  },

  mounted() {
    this.getData();
  },
});

app.mount('#app');