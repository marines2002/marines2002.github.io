    using System;
    using System.Collections.Generic;
    using System.Text;
    using System.Web;
    using System.IO;
    using System.Xml;
    using System.Xml.XPath;
    using System.Xml.Serialization;
    using System.Collections;
    using System.Diagnostics;
    using System.Globalization;
    using System.Reflection;
    using System.Configuration;
    using System.Collections.Specialized;

    /// <summary>
    /// Container for a complete set of Services.
    /// </summary>
    [Serializable]
    [XmlRoot("Services")]
    public class ServiceCollection : CollectionBase, IEnumerable<Service>
    {
        /// <summary>
        /// Create a new asset collection
        /// </summary>
        public ServiceCollection()
            : base()
        {
        }

        /// <summary>
        /// Publish a specific Asset from this 
        /// collection based on its index.
        /// </summary>
        /// <param name="index">Index of the Asset to access.</param>
        public Service this[int index]
        {
            get { return (Service)InnerList[index]; }
            set { InnerList[index] = (Service)value; }
        }

        /// <summary>
        /// Add a new Asset
        /// </summary>
        /// <param name="item">The Asset to add.</param>
        /// <returns>New Asset's index.</returns>
        public int Add(Service item)
        {
            if (item == null)
            {
                throw new ArgumentNullException("item");
            }

            if (item.Id == null || item.Id.Length == 0)
            {
                throw new ArgumentException("Error", "item");
            }

            return InnerList.Add(item);
        }

        /// <summary>
        /// Check if the Collection contains the passed Asset
        /// </summary>
        /// <param name="item">The Asset to check.</param>
        /// <returns>True if found.</returns>
        public bool Contains(Service item)
        {
            return InnerList.Contains(item);
        }

        /// <summary>
        /// Insert a Asset into the collection.
        /// </summary>
        /// <param name="index">Zero based index at which the Asset should be inserted.</param>
        /// <param name="item">The Asset to insert.</param>
        public void Insert(int index, Service item)
        {
            if (item == null)
            {
                throw new ArgumentNullException("item");
            }

            if ((item.Id == null) || (item.Id.Length == 0))
            {
                throw new ArgumentException("Error", "item");
            }

            if (!this.ContainsId(item.Id))
            {
                InnerList.Insert(index, item);
            }
            else
            {
                throw new ArgumentException("Error", "item");
            }
        }

        /// <summary>
        /// Remove the passed Asset from the collection.
        /// </summary>
        /// <param name="item">The Asset to remove.</param>
        public void Remove(Service item)
        {
            InnerList.Remove(item);
        }

        /// <summary>
        /// Get the Zero based index of the passed Asset within the collection.
        /// </summary>
        /// <param name="item">The Asset to get the index of.</param>
        /// <returns>The index of the Asset.</returns>
        public int IndexOf(Service item)
        {
            return InnerList.IndexOf(item);
        }

        /// <summary>
        /// Copy this collection into an array of Assets.
        /// </summary>
        /// <param name="array">The target Asset[].</param>
        /// <param name="index">The Zero based index at which to start the copy.</param>
        public void CopyTo(Service[] array, int index)
        {
            InnerList.CopyTo(array, index);
        }

        /// <summary>
        /// Publish the Enumerator for this collection.
        /// </summary>
        /// <returns>An <see cref="IEnumerator"/> for Asset types.</returns>
        public new IEnumerator<Service> GetEnumerator()
        {
            foreach (Service client in InnerList)
            {
                yield return client;
            }
        }

        /// <summary>
        /// Check if the Collection contains a Client with the guid.
        /// </summary>
        /// <param name="guid">The Id to look for.</param>
        /// <returns>Try if found.</returns>
        public bool ContainsId(string guid)
        {
            bool found = false;

            if (guid != null)
            {
                foreach (Service client in this)
                {
                    if (0 == string.Compare(guid, client.Id, StringComparison.OrdinalIgnoreCase))
                    {
                        found = true;
                        break;
                    }
                }
            }

            return found;
        }
    }   

