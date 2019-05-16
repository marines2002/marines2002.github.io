
    using System;
    using System.Collections;
    using System.IO;
    using System.Xml;
    using System.Xml.Serialization;

    /// <summary>
    /// Set Top Box settings class
    /// </summary>
    [Serializable]
    [XmlRoot("Service")]
    public class Service
    {
        private string id = "";
        private string name = "";
        private string description = "";
        private string telephone = "";
        private string link = "";
        
        /// <summary>
        /// Default constructor 
        /// </summary>
        public Service()
        {
        }

        public Service(string name, string description, string telephone, string link, string id)
        {
            this.name = name;
            this.description = description;
            this.telephone = telephone;
            this.link = link;
            this.id = id;
        }

        /// <summary>
        /// Id
        /// </summary>
        [XmlElement("Id")]
        public string Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// User
        /// </summary>
        [XmlElement("Name")]
        public string Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        [XmlElement("Description")]
        public string Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        [XmlElement("Telephone")]
        public string Telephone
        {
            get { return this.telephone; }
            set { this.telephone = value; }
        }

        [XmlElement("Link")]
        public string Link
        {
            get { return this.link; }
            set { this.link = value; }
        }
   }
