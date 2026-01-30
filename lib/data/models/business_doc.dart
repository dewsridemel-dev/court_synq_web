class BusinessDoc {
    final String id;
    final String doc_name;
    final String doc_expire_date;
    final String created_at;
    
    const BusinessDoc({
        required this.id,
        required this.doc_name,
        required this.doc_expire_date,
        required this.created_at,
    });

    factory BusinessDoc.fromJson(Map<String, dynamic> json) {
        return BusinessDoc(
            id: json['id'],
            doc_name: json['doc_name'],
            doc_expire_date: json['doc_expire_date'],
            created_at: json['created_at']
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'doc_name': doc_name,
            'doc_expire_date': doc_expire_date,
            'created_at': created_at,
        };
    }
}