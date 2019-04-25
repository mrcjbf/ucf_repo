
def remove_ds_store_file(activities):
    try:
     activities.remove('.DS_Store')
    except ValueError:
        pass