-StoreKeeper
StoreKeeper is an offline inventory management app that helps you efficiently manage products, quantities, prices, and status. Designed for simplicity and robustness, it ensures your inventory is organized, reliable, and always accessible.

-Features
Add Products Easily
Add a photo (optional), provide the product name, description, quantity, price (or 0 if unknown), and status. Everything is stored securely in the local database.

Local Database Storage
Products are stored locally using Drift. Your data remains safe even offline, and all product images are stored in app-specific storage to prevent accidental deletion.

Automatic Image Management
When you add a product, the image is saved in the app's private storage.
When you delete a product, its image is completely removed from the device.
This ensures data integrity even if the original image in the gallery is deleted.

State Management with RiverPod
Efficiently handles app state for a smooth and reactive experience.

Navigation with GoRouter
Seamless routing between screens with clean and maintainable navigation.

Clean MVVM Architecture
Separates UI, business logic, and data layers for maintainable and scalable code.

User-Friendly UI
Easy-to-use interface to view, edit, or delete products, complete with product details and status labels.

-How it Works
Add a Product:
Input the product name, description, quantity, and price.
Snap a photo or choose one from your gallery (optional).
Choose product status: InStock or Limited.

Manage Inventory:
View all products in a list.
Filter products using the search bar.
Edit or delete products as needed.

Safe Data Handling:
Product images are stored in the app’s local storage.
Deleting a product ensures associated images are also removed.

Technologies Used
Flutter – Cross-platform UI toolkit
Drift – Local database for storing products
RiverPod – State management
GoRouter – Navigation
Clean MVVM Architecture – Separation of concerns for maintainable code
Google Fonts & Custom UI Components – Polished, professional look

-Preview & APK
App Preview: [Link to preview](https://appetize.io/app/b_lo3h77tyhg2fkezkdqabsxsmsy)
APK & Demo Media: [Google Drive](https://drive.google.com/file/d/1XuSKRBexLQ4H3T0MYQ_SPMCCR1jABEpG/view?usp=share_link)

-Screenshots

<img width="200" height="550"   alt="StoreKeeper2" src="https://github.com/user-attachments/assets/3fc6f72c-54d3-42dd-a939-13c6cb454821" />
<img width="200" height="550"   alt="StoreKeeper6" src="https://github.com/user-attachments/assets/2d2fb6a1-88d1-4fa4-a4dc-5582694cc629" />
<img width="200" height="550"   alt="StoreKeeper5" src="https://github.com/user-attachments/assets/5c244355-9352-4567-a9db-933f27e3fa13" />
<img width="200" height="550"   alt="StoreKeeper4" src="https://github.com/user-attachments/assets/9214854d-d5a5-4964-b150-1534ee5099ca" />
<img width="200" height="550"   alt="StoreKeeper3" src="https://github.com/user-attachments/assets/8f5891d0-cd83-4b5d-91a3-3f0d315435a1" />
<img width="200" height="550"   alt="StoreKeeper1" src="https://github.com/user-attachments/assets/df98493e-fc8f-4362-a92a-a312ed9847b6" />


License
MIT License – Feel free to use, modify, and distribute this project.
