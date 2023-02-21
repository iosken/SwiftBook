//
//  TrackListViewController.swift
//  SwiftBook
//
//  Created by Юрий Волегов on 21.02.2023.
//

import UIKit

class TrackListViewController: UITableViewController {
    var trackList = Track.getTrackList()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
        
        let track = trackList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
        content.text = track.song
        content.secondaryText = track.artist
        
        content.image = UIImage(named: track.title)
        
        content.imageProperties.cornerRadius = tableView.rowHeight / 2

        cell.contentConfiguration = content
        
        return cell
    }

    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = trackList[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: track)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentTrack = trackList.remove(at: sourceIndexPath.row)
        trackList.insert(currentTrack, at: destinationIndexPath.row)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? TrackDetailsViewController else { return }
        
        // guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // detailsVC.track = trackList[indexPath.row]
        
        
        detailsVC.track = sender as? Track
    }

}
